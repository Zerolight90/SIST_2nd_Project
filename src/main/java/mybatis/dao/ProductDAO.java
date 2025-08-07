package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ProductVO;
import org.apache.ibatis.session.SqlSession;
import java.util.List;

public class ProductDAO {

    /**
     * 판매 중인 모든 상품의 목록을 반환합니다. (스토어 메인 페이지용)
     * @return ProductVO 객체들을 담은 List
     */
    public static List<ProductVO> getAllProducts() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<ProductVO> list = ss.selectList("product.getAllProduct");
        ss.close();
        return list;
    }

    public static ProductVO[] getAllProd(){
        ProductVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<ProductVO> list = ss.selectList("product.getAllProd");
        ar = new ProductVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    /**
     * 상품 ID를 이용해 특정 상품의 상세 정보를 반환합니다. (결제 페이지 준비용)
     * @param productIdx 조회할 상품의 ID
     * @return 해당 ID의 ProductVO 객체
     */
    public static ProductVO getProductById(int productIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        ProductVO vo = ss.selectOne("product.getProductById", productIdx);
        ss.close();
        return vo;
    }
}