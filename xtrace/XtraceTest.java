import java.io.File;
import java.io.UnsupportedEncodingException;

class XtraceTest {
	static int counter = 0;
	static double size1 = 0.0d;
	static double size2 = 0.0d;
	public static void main(String[] args) {
		String filePattern = "trace";
		String dirPath = args[0];
                System.out.println("Directory path for traces - " + dirPath);

		displayCounter(dirPath, filePattern);
		
		if (counter != 1000) {
			System.out.println("Failed: Counter value not 1000 after restore");
		}

		displayCounter(dirPath, filePattern);

		if (counter != 2000) {
			System.out.println("Failed: Counter value not 2000");
		}

		size2 = checkFileExistsAndReturnSize(dirPath, filePattern);

		if (!(size2 > size1)) {
			System.out.println("Failed - Trace file size after restore does not increase, before checkpoint - " + size1 + "KB after checkpoint - " + size2 + "KB");
		}
	}

	public static void displayCounter(String dirPath, String filePattern) {
		for (int i = 0; i < 1000; i++) {

			if (counter == 200){
				size1 = checkFileExistsAndReturnSize(dirPath, filePattern);
				System.out.println("Checkpoint now");
				String checkpoint = dirPath + "/checkpoint";
		                System.out.println(checkpoint);
		                File check = new File(checkpoint);
		                while(true) {
		                        if (check.exists()) {
		                                break;
                		        }
		                }
                		System.out.println("After checkpoint...");
			}
			counter = counter + 1;
		}

	}


	 public static double checkFileExistsAndReturnSize(String dirPath, String filePattern) {
                File dir = new File(dirPath);
                File[] dirContents = dir.listFiles();
                boolean found = false;
                int count = 0;
		double bytes = 0.0d;
		double kilobytes = 0.0d;

                for (File file : dirContents) {
                        if (file.isFile()) {
                                String fileName = file.getName();
                                if (fileName.startsWith(filePattern)) {
                                        found = true;
                                        count++;
					bytes = file.length();
					kilobytes = (bytes / 1024);
                                        System.out.println("File Name = " + fileName + " File size = " + kilobytes + "KB");
                                }
                        }
                }

                if (found == true) {
                        if (count == 1) {
                                System.out.println(filePattern + " - found!");
                        } else {
                                System.out.println("Error: Multiple " + filePattern + " found!");
                        }

                } else {
                        System.out.println("Failed: No " + filePattern + " found!");

                }
		return kilobytes;
	 }

}
