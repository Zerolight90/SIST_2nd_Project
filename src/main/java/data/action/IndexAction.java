package data.action;

import data.dao.DataDAO;
import mybatis.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction implements Action{

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        try {
            DataVO[] ar = DataDAO.getMovie();

            /*int i = 0;
            for (DataVO vo : ar){
                String movie_id = vo.getMovie_id();
                String title = vo.getTitle();
                String overview = vo.getOverview();
                String poster_path = vo.getPoster_path();
                String release_date = vo.getRelease_date();
                String popularity = vo.getPopularity();
                String vote_average = vo.getVote_average();

                vo = new DataVO(movie_id, title, overview, poster_path, release_date, popularity, vote_average);
                ar[i++] = vo;
            } // for 끝*/

            request.setAttribute("ar", ar);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "index.jsp";
    }

}
