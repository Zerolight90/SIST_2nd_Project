package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.PriceVO;
import org.apache.ibatis.session.SqlSession;

public class PriceDAO {
    public static PriceVO getPrice(){
        PriceVO price = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        price = (PriceVO) ss.selectOne("price.getPrice");
        ss.close();
        return price;
    }
}
