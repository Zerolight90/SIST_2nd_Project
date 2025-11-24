package mybatis.dao;

import mybatis.Service.FactoryService; // 기존 FactoryService 임포트
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory; // SqlSessionFactory는 여전히 필요

public class MoviedetailDAO {

    public MovieVO getMovieDetail(int mIdx) {

        SqlSessionFactory sessionFactory = FactoryService.getFactory();
        SqlSession session = null;
        MovieVO movie = null;
        try {
            session = sessionFactory.openSession();

            movie = session.selectOne("movieDetail.getMovieById", mIdx);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return movie;
    }
}
