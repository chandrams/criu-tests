import java.io.UnsupportedEncodingException;
import java.io.File;

public class XdumpTest {
	public static void main(String args[]) throws Exception {
		String dirPath = args[0];
		System.out.println("Directory path for dumps - " + dirPath);

		System.out.println("Delete all old dump files if any");
		deleteAllOldDumps(dirPath);
		try {
			new String("hello").getBytes("Unsupported");
	            } catch (UnsupportedEncodingException e) {
			/* Expected exception from getBytes() hence ignored */
	    	}

		checkFileExists(dirPath);

		System.out.println("Checkpoint now");

		String checkpoint = dirPath + "/../checkpoint";
		System.out.println(checkpoint);
	        File check = new File(checkpoint);
		while(true) {
			if (check.exists()) {
				break;
			}
		}

		System.out.println("After checkpoint...");
		try {
			new String("hello").getBytes("Unsupported");
		} catch (UnsupportedEncodingException e) {
			/* Expected exception from getBytes() hence ignored */
		}

		// Check if javacore is created after restore
		checkFileExists(dirPath);
	}

	public static void checkFileExists(String dirPath) {
	    	File dir = new File(dirPath);
		File[] dirContents = dir.listFiles();
		boolean found = false;
		int count = 0;
		
		for (File file : dirContents) {
                	if (file.isFile()) {
                                String fileName = file.getName();
                                if (fileName.startsWith("javacore")) {
                                        found = true;
                                        count++;
					System.out.println(fileName);
					file.delete();
                                }
                        }
                }

                if (found == true) {
                        if (count == 1) {
                                System.out.println("javacore found!");
                        } else {
                                System.out.println("Error: Multiple javacores found!");
                        }

                } else {
                        System.out.println("Failed: No javacore found!");

                }
    }

    public static void deleteAllOldDumps(String dirPath) {
	    	File dir = new File(dirPath);
		if (dir.exists() && dir.isDirectory()) {
			File[] dirContents = dir.listFiles();
		
			for (File file : dirContents) {
        	        	if (file.isFile()) {
					file.delete();
                       		}
	                }
		}

    }
}
