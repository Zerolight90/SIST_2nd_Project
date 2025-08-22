package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.TheaterInfoBoardVO;
import mybatis.vo.TheaterVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class AdminTheaterBoardDAO {

    //극장 추가
    public static int add(TheaterVO tvo, TheaterInfoBoardVO infovo){

        int cnt = 0;

        // openSession(false)로 자동 커밋을 비활성화하여 트랜잭션 수동 제어
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            // theater 테이블 먼저 INSERT
            ss.insert("adminTheaterBoard.addTheater", tvo);

            // INSERT 후 생성된 tIdx 값을 TheaterVO에서 가져와 TheaterInfoBoardVO에 설정
            // MyBatis의 useGeneratedKeys 속성으로 tvo.getTIdx()에 값이 자동으로 담김
            infovo.settIdx(tvo.gettIdx());

            // theater_info_board 테이블에 INSERT
            cnt = ss.insert("adminTheaterBoard.addTheaterInfo", infovo);

            // 두 쿼리가 모두 성공적으로 실행된 경우에만 최종 커밋
            ss.commit();

        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback(); // 예외 발생 시 전체 롤백
            cnt = -1; // 실패
        } finally {
            if (ss != null)

                ss.close();
        }

        return cnt;
    }


    //극장 정보 보기
    public static TheaterInfoBoardVO getTheaterBoard(String tIdx){

        SqlSession ss = FactoryService.getFactory().openSession();
        TheaterInfoBoardVO infovo = ss.selectOne("adminTheaterBoard.getTheaterBoard", tIdx);

        ss.close();

        return infovo;
    }


    //극장 정보 수정
    //게시글 수정
    public static int edit(TheaterVO tvo, TheaterInfoBoardVO infovo){

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = 0;

        try {
            // theater 테이블 먼저 UPDATE
            ss.update("adminTheaterBoard.editTheater", tvo);

            // INSERT 후 생성된 tIdx 값을 TheaterVO에서 가져와 TheaterInfoBoardVO에 설정
            // MyBatis의 useGeneratedKeys 속성으로 tvo.getTIdx()에 값이 자동으로 담김
            infovo.settIdx(tvo.gettIdx());

            // theater_info_board 테이블에 INSERT
            cnt = ss.update("adminTheaterBoard.editTheaterInfo", infovo);

            // 두 쿼리가 모두 성공적으로 실행된 경우에만 최종 커밋
            ss.commit();

        } catch (Exception e) {
            e.printStackTrace();
            ss.rollback(); // 예외 발생 시 전체 롤백
            cnt = -1; // 실패
        } finally {
            if (ss != null)

                ss.close();
        }

        return cnt;
    }
}