package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.MovieVO;
import mybatis.vo.ScreenVO;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
    public static List<MovieVO> getList(String now) {
        List<MovieVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        list = ss.selectList("timeTable.all", now);

        ss.close();
        return list;
    }
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
    public static MovieVO getById(String mIdx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MovieVO movie = ss.selectOne("movie.list", mIdx);
        ss.close();
        return movie;
    }
}
