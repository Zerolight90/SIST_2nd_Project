package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.ProductVO;
import org.apache.ibatis.session.SqlSession;
import java.util.List;
import java.util.Map;

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

    public static ProductVO[] getSnackProd(){
        ProductVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<ProductVO> list = ss.selectList("product.getSnackProd");
        ar = new ProductVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static ProductVO[] getTicketProd(){
        ProductVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<ProductVO> list = ss.selectList("product.getTicketProd");
        ar = new ProductVO[list.size()];
        list.toArray(ar);

        ss.close();
        return ar;
    }

    public static ProductVO getSelectProd(String prodIdx){
        ProductVO vo = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        vo = ss.selectOne("product.getSelectProd", prodIdx);

        ss.close();
        return vo;
    }

    public static void productAdd(Map<String, String> map){

        SqlSession ss = FactoryService.getFactory().openSession();
        int insert = ss.insert("product.productAdd", map);

        if (insert >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
    }
    public static void productCer(Map<String, String> map){
        SqlSession ss = FactoryService.getFactory().openSession();
        int update = ss.update("product.productCer", map);

        if (update >= 1){
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
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

    /**
     * 상품 재고를 감소시키고, 재고가 0 이하가 되면 상태를 '품절'로 변경하는 메소드
     * @param params prodIdx(상품ID), quantity(구매수량)가 담긴 Map
     * @param ss 트랜잭션 관리를 위한 SqlSession
     * @return 업데이트된 행의 수
     */
    public static int updateProductStock(Map<String, Object> params, SqlSession ss) {
        return ss.update("product.updateStock", params);
    }
}