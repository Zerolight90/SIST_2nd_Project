package mybatis.dao;

import mybatis.Service.FactoryService;
import mybatis.vo.UsersVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UsersDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String bname){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("bbs.totalCount", bname);
        ss.close();
        return cnt;
    }

    // 목록 반환
    public static UsersVO[] getList(String bname, int begin, int end){
        UsersVO[] ar = null;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bname", bname);
        map.put("begin", begin);
        map.put("end", end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<UsersVO> list = ss.selectList("bbs.list", map);
        if(list != null && list.size() > 0){
            ar = new UsersVO[list.size()];
            list.toArray(ar);// list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();

        return ar;
    }
}
