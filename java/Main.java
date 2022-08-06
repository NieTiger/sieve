import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Main {
  public static Integer[] sieve(int size) {
    if (size < 2) {
      return new Integer[0];
    }

    boolean[] a = new boolean[size/2];
    int q = (int) Math.sqrt(size);
    int factor = 3;

    while (factor < q) {
      for (int i = factor; i < size; i += 2) {
        if (!a[i>>1]) {
          factor = i;
          break;
        }
      }

      for (int i = factor * factor; i < size; i += factor * 2) {
        a[i>>1] = true;
      }

      factor += 2;
    }

    ArrayList<Integer> res = new ArrayList<Integer>();
    res.add(2);

    for (int i = 3; i < size; i += 2) {
      if (!a[i>>1]) {
        res.add(i);
      }
    }
    return res.toArray(new Integer[0]);
  }

  public static Integer[] load_truth() {
    ArrayList<Integer> truth = new ArrayList<Integer>();
    String raw = "";
    try {
      File fp = new File("../truth.txt");
      Scanner scanner = new Scanner(fp);
      raw = scanner.nextLine();
      scanner.close();
    } catch (FileNotFoundException e) {
      System.out.println(e);
      System.exit(1);
    }
    for (String v : raw.split(" ")) {
      truth.add(Integer.parseInt(v));
    }
    return truth.toArray(new Integer[0]);
  }

  public static void main(String[] args) {
    int size = 1000000;

    // Test impl
    Integer[] res = Main.sieve(size);
    Integer[] truth = Main.load_truth();

    if (truth.length != res.length) {
      System.out.println("Impl incorrect");
      System.exit(1);
    }

    for (int i = 0; i < truth.length; i += 1) {
      if (res[i].intValue() != truth[i].intValue()) {
        System.out.println("Impl incorrect");
        System.exit(1);
      }
    }

    // Bench
    long duration_ms = 5 * 1000;
    long start = System.currentTimeMillis();
    int passes = 0;
    while (System.currentTimeMillis() - start < duration_ms) {
      Main.sieve(size);
      passes += 1;
    }
    System.out.println(passes);
  }
}
