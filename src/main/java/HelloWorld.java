import com.google.common.base.Joiner;

public class HelloWorld {
    public static void main(String[] args) {
        String message = Joiner.on(" ").join(args.length > 0 ? args : new String[] {"World!"});
        System.out.println("Hello, " + message);
    }
}

