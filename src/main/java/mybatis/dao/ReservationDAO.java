package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MyReservationVO;
import mybatis.vo.ReservationVO;
import mybatis.vo.TimeTableVO;
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
    public static int insertReservation(ReservationVO vo, SqlSession ss) {
        return ss.insert("reservation.insertReservation", vo);
    }

    // 특정 사용자의 예매 내역 총 개수 조회
    public static int getTotalReservationCount(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("reservation.getTotalReservationCount", params);
        ss.close();
        return count;
    }

    // 특정 사용자의 예매 내역 목록 조회
    public static List<MyReservationVO> getReservationList(Map<String, Object> params) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MyReservationVO> list = ss.selectList("reservation.getReservationList", params);
        ss.close();
        return list;
    }

    // 결제 취소(환불)
    public static int updateReservationToCancelled(long reservIdx, SqlSession ss) {
        return ss.update("reservation.updateReservationToCancelled", reservIdx);
    }

    public static TimeTableVO getScreeningTimeByReservIdx(Long reservIdx, SqlSession ss) {
        return ss.selectOne("reservation.getScreeningTime", reservIdx);
    }
}