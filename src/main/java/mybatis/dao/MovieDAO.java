package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class MovieDAO {

    public static MovieVO[] getAllMovie() {
        MovieVO[] ar = null;

        try {
            SqlSession ss = FactoryService.getFactory().openSession();
            List<MovieVO> list = ss.selectList("movie.getMovieInfo");
            ar = new MovieVO[list.size()];
            list.toArray(ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ar;
    }

}
