package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.SeatVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class SeatDAO {

    public static SeatVO[] reserveSeat(String timeTableIdx){
        List<SeatVO> list = null;
        SeatVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        list = ss.selectList("seat.reserveSeat", timeTableIdx);
        ar = new SeatVO[list.size()];
        list.toArray(ar);
        ss.close();

        return ar;
    }
}

