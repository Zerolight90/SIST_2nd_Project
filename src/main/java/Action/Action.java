package Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface Action {
    String execute (HttpServletRequest request, HttpServletResponse response) throws IOException;

}
