package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PointVO;
import org.apache.ibatis.session.SqlSession;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PointDAO {

    /**
     * 포인트 사용을 처리하는 트랜잭션 메소드
     *
     * @param userIdx     사용자 ID
     * @param usedPoints 사용할 포인트
     * @param paymentIdx  관련 결제 ID
     * @param ss
     * @return 성공 시 1, 실패 시 0
     */
    public static void usePoints(long userIdx, int usedPoints, long paymentIdx, SqlSession ss) throws Exception {
        // 1. user 테이블의 totalPoints 업데이트
        Map<String, Object> params = new HashMap<>();
        params.put("userIdx", userIdx);
        params.put("pointsToUse", usedPoints);

        int updatedRows = ss.update("point.decreaseUserPoints", params);
        if (updatedRows == 0) {
            throw new Exception("사용자(" + userIdx + ")의 포인트를 업데이트하지 못했습니다.");
        }

        // 2. point 테이블에 사용 내역(음수) 기록
        PointVO pvo = new PointVO();
        pvo.setUserIdx(userIdx);
        pvo.setPaymentIdx(paymentIdx);
        pvo.setTransactionType(1); // 0: 적립, 1: 사용
        pvo.setAmount(-usedPoints); // 사용한 포인트는 음수로 기록
        pvo.setDescription("결제 시 포인트 사용");
        pvo.setTransactionDate(new Date()); // 현재 시간으로 설정

        int insertedRows = ss.insert("point.insertPointHistory", pvo);
        if (insertedRows == 0) {
            throw new Exception("포인트 사용 내역을 기록하지 못했습니다.");
        }
    }
    // 특정 사용자의 포인트 사용/적립 내역 조회
    public static List<PointVO> getPointHistory(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<PointVO> list = ss.selectList("point.getHistory", userIdx);
        ss.close();
        return list;
    }

    public static void revertPointUsage(long userIdx, int pointsToRevert, long paymentIdx, SqlSession ss) {
        // 1. 사용자 포인트 되돌리기
        Map<String, Object> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("pointsToRevert", pointsToRevert);
        ss.update("point.addUserPoints", map);

        // 2. 포인트 환불 내역 기록
        PointVO pvo = new PointVO();
        pvo.setUserIdx(userIdx);
        pvo.setAmount(pointsToRevert);
        pvo.setRelatedPaymentIdx(paymentIdx); // 어떤 결제 건과 관련된 환불인지 기록
        ss.insert("point.insertPointRefundHistory", pvo);
    }
}