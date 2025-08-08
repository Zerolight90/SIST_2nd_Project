package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyReservationVO;
import mybatis.vo.ReservationVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReservationDAO {

    // 예매 번호로 결제에 필요한 상세 정보 조회
    public static ReservationVO getReservationDetails(long reservIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        ReservationVO vo = ss.selectOne("reservation.getDetails", reservIdx);
        ss.close();
        return vo;
    }

    // 결제 완료 후 예매 상태 변경
    public static int updateStatusToPaid(long reservIdx) {
        SqlSession ss = FactoryService.getFactory().openSession(false);
        int result = ss.update("reservation.updateStatusToPaid", reservIdx);
        if (result > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return result;
    }

    // 결제 완료 후 예매 정보를 DB에 저장하고 생성된 reservIdx를 반환하는 메소드
    public static long insertReservation(ReservationVO vo, SqlSession ss) {
        ss = FactoryService.getFactory().openSession(false);
        try {
            ss.insert("reservation.insertReservation", vo);
            ss.commit();
        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback();
        } finally {
            if (ss != null) {
                ss.close();
            }
        }
        return vo.getReservIdx(); // keyProperty에 의해 채워진 reservIdx 반환
    }

    // 특정 사용자의 예매 내역 총 개수 조회 (페이징용)
    public static int getTotalReservationCount(long userIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("reservation.getTotalCount", userIdx);
        ss.close();
        return count;
    }

    // 특정 사용자의 예매 내역 목록 조회 (페이징 처리)
    public static List<MyReservationVO> getReservationList(long userIdx, int begin, int end) {
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, Object> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("begin", begin);
        map.put("end", end);
        List<MyReservationVO> list = ss.selectList("reservation.getList", map);
        ss.close();
        return list;
    }
}