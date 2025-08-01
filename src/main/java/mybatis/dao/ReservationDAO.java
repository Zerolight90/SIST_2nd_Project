package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ReservationVO;
import org.apache.ibatis.session.SqlSession;

public class ReservationDAO {

    // 예매 ID로 상세 정보 조회
    public static ReservationVO getReservationDetails(long reservIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        ReservationVO vo = ss.selectOne("reservation.getDetails", reservIdx);
        ss.close();
        return vo;
    }
}