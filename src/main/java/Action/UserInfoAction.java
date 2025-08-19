package Action;

import mybatis.dao.MemberDAO;
import mybatis.vo.MemberVO;
import mybatis.vo.KakaoVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;

public class UserInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = null;
        ObjectMapper mapper = new ObjectMapper();

        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("success", false);
        responseMap.put("message", "처리 실패");

        try {
            out = response.getWriter();

            String actionType = request.getParameter("action");
            String birthdate = request.getParameter("birth");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            HttpSession session = request.getSession();
            String userId = null;
            Object userVO = null;

            if (session.getAttribute("mvo") != null) {
                MemberVO mvo = (MemberVO) session.getAttribute("mvo");
                userId = mvo.getId();
                userVO = mvo;
            } else if (session.getAttribute("kvo") != null) {
                KakaoVO kvo = (KakaoVO) session.getAttribute("kvo");
                userId = kvo.getK_id();
                userVO = kvo;
            }

            if (userId != null) {
                // 1) 세션에 비밀번호 임시 저장 (stage)
                if ("stagePassword".equals(actionType) && password != null && !password.trim().isEmpty()) {
                    session.setAttribute("stagedPw", password);
                    // 화면 동기화를 위해 mvo 내부 pw도 갱신 (mvo가 있는 경우)
                    if (userVO instanceof MemberVO) {
                        ((MemberVO) userVO).setPw(password);
                        session.setAttribute("mvo", userVO);
                    }
                    responseMap.put("success", true);
                    responseMap.put("message", "비밀번호가 세션에 임시 저장되었습니다.");
                }
                // 2) 세션에 저장된 비밀번호를 DB에 커밋 (commit)
                else if ("commitStagedPassword".equals(actionType)) {
                    String staged = (String) session.getAttribute("stagedPw");
                    if (staged != null && !staged.isEmpty()) {
                        int result = MemberDAO.updatePassword(userId, staged);
                        if (result > 0) {
                            session.removeAttribute("stagedPw");
                            if (userVO instanceof MemberVO) {
                                ((MemberVO) userVO).setPw(staged);
                                session.setAttribute("mvo", userVO);
                            }
                            responseMap.put("success", true);
                            responseMap.put("message", "세션 비밀번호가 DB에 반영되었습니다.");
                        } else {
                            responseMap.put("message", "비밀번호 DB 반영 실패");
                        }
                    } else {
                        responseMap.put("message", "세션에 저장된 비밀번호가 없습니다.");
                    }
                }
                // 기존 birth 업데이트
                else if ("updateBirthdate".equals(actionType) && birthdate != null && !birthdate.trim().isEmpty()) {
                    int result = MemberDAO.updateBirthdate(userId, birthdate);
                    if (result > 0) {
                        if (userVO instanceof MemberVO) {
                            ((MemberVO) userVO).setBirth(birthdate);
                        } else if (userVO instanceof KakaoVO) {
                            ((KakaoVO) userVO).setBirth(birthdate);
                        }
                        session.setAttribute(userVO instanceof MemberVO ? "mvo" : "kvo", userVO);
                        responseMap.put("success", true);
                        responseMap.put("message", "생년월일이 성공적으로 업데이트되었습니다.");
                    } else {
                        responseMap.put("message", "생년월일 업데이트에 실패했습니다.");
                    }
                }
                // 기존 phone 업데이트
                else if ("updatePhone".equals(actionType) && phone != null && !phone.trim().isEmpty()) {
                    int result = MemberDAO.updatePhone(userId, phone);
                    if (result > 0) {
                        if (userVO instanceof MemberVO) {
                            ((MemberVO) userVO).setPhone(phone);
                        } else if (userVO instanceof KakaoVO) {
                            ((KakaoVO) userVO).setPhone(phone);
                        }
                        session.setAttribute(userVO instanceof MemberVO ? "mvo" : "kvo", userVO);
                        responseMap.put("success", true);
                        responseMap.put("message", "휴대폰 번호가 성공적으로 업데이트되었습니다.");
                    } else {
                        responseMap.put("message", "휴대폰 번호 업데이트에 실패했습니다.");
                    }
                } else {
                    responseMap.put("message", "유효한 업데이트 요청이 아니거나 필요한 값이 누락되었습니다.");
                }
            } else {
                responseMap.put("message", "로그인 정보가 유효하지 않습니다.");
            }

            out.print(mapper.writeValueAsString(responseMap));
            out.flush();

        } catch (IOException e) {
            e.printStackTrace();
            responseMap.put("message", "서버 오류가 발생했습니다.");
            try {
                if (out != null) {
                    out.print(mapper.writeValueAsString(responseMap));
                    out.flush();
                }
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } finally {
            if (out != null) {
                out.close();
            }
        }
        return null;
    }
}
