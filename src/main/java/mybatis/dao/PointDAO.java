package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PointVO;
import org.apache.ibatis.session.SqlSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PointDAO {

    /**
     * 포인트 사용을 처리하는 트랜잭션 메소드
     * @param userIdx 사용자 ID
     * @param pointsToUse 사용할 포인트
     * @param paymentIdx 관련 결제 ID
     * @return 성공 시 1, 실패 시 0
     */
    public static int usePoints(long userIdx, int pointsToUse, long paymentIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false); // 트랜잭션 시작
        int result = 0;
        try {
            // 1. user 테이블의 totalPoints 차감
            Map<String, Object> userMap = new HashMap<>();
            userMap.put("userIdx", userIdx);
            userMap.put("pointsToUse", pointsToUse);
            int updateUserResult = ss.update("point.deductUserPoints", userMap);

            if (updateUserResult > 0) {
                // 2. point 테이블에 사용 내역 기록
                PointVO pvo = new PointVO();
                pvo.setUserIdx(userIdx);
                pvo.setPaymentIdx(paymentIdx);
                pvo.setTransactionType(1); // 1: 사용
                pvo.setAmount(pointsToUse * -1); // 차감이므로 음수로 기록
                pvo.setDescription("영화 예매 시 포인트 사용");
                int insertPointResult = ss.insert("point.insertPointHistory", pvo);

                if (insertPointResult > 0) {
                    ss.commit(); // 2개 작업 모두 성공 시 최종 반영
                    result = 1;
                } else {
                    ss.rollback(); // 실패 시 되돌리기
                }
            } else {
                // 보유 포인트 부족 등으로 차감 실패 시
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback(); // 예외 발생 시 되돌리기
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return result;
    }
    // [추가] 특정 사용자의 포인트 사용/적립 내역 조회
    public static List<PointVO> getPointHistory(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<PointVO> list = ss.selectList("point.getHistory", userIdx);
        ss.close();
        return list;
    }
}