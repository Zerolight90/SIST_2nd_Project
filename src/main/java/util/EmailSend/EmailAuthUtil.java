package util.EmailSend;

import java.security.SecureRandom;

public class EmailAuthUtil {
    private static final SecureRandom random = new SecureRandom();

    public static String AuthCode(){
        int code = random.nextInt(1_000_000);

        System.out.println(code);
        return String.format("%06d", code);

    }

}
