package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.AdminBoardVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class AdminBoardDAO {

    //목록 반환
    public static AdminBoardVO[] getList(){
        AdminBoardVO[] ar = null;

        HashMap<String, Object> map = new HashMap<>();

        SqlSession ss = FactoryService.getFactory().openSession();
        List<AdminBoardVO> list = ss.selectList("board.adminBoardList", map);

        if(list != null && !list.isEmpty()){
            ar = new AdminBoardVO[list.size()];
            list.toArray(ar); //list에 있는 모든 항목들을 배열 ar에 복사
        }
        return ar;
    }
}
