package util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

public class ConfigUtil {
    private static final Properties props = new Properties();

    static {
        // 클래스패스 내 리소스 접근

        try (InputStream input = ConfigUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                props.load(new InputStreamReader(input, "UTF-8"));
            } else {
                throw new IOException("config.properties 파일을 찾을 수 없습니다.");
            }
        } catch (IOException e) {
//            throw new ExceptionInInitializerError("설정 파일 로딩 실패: " + e.getMessage());
        }

    }

    public static String getProperty(String key) {
        return props.getProperty(key);
    }
}

