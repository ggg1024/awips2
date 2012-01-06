/**
 * This Java class is the JUnit test for the intlsigmet decoder separator.
 *
 * <pre>
 *
 * L. Lin       07/09   Creation
 * </pre>
 *
 */

package gov.noaa.nws.ncep.edex.plugin.intlsigmet.decoder;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;

public class IntlSigmetSeparatorTest {
        IntlSigmetSeparator sep;
        char[] cbuf;
        int ntime = 0;
        StringBuffer contents = new StringBuffer();
        byte[]  actual = null;

        @Before
        public void setUp() throws Exception {
                sep = new IntlSigmetSeparator();
                File file = new File ("unit-test/gov/noaa/nws/ncep/edex/plugin/intlsigmet/decoder/2009060816.isig");
                System.out.println(file.toString());
                BufferedReader reader = null;
                
            try {
            reader = new BufferedReader(new FileReader(file));
            String text = null;

            // repeat until all lines is read
            while ((text = reader.readLine()) != null) {
                if ( text.length() != 0 ) {
                        contents.append(text).append("\r\r\n");
                }
            }
        }
            catch (FileNotFoundException e) {
            e.printStackTrace();
        }
            catch (IOException e) {
            e.printStackTrace();
        }
            finally {
                try {
                    if (reader != null) {
                        reader.close();
                    }
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
                sep = new IntlSigmetSeparator();
                actual = contents.toString().getBytes();
                sep.setData(actual, null);

        }
            
            @Test
            public void testHasNext() {
                    assertTrue("Find Convsigmet separator! ", sep.hasNext());
            }

            @Test
            public void testGetRecord() {
                    byte[] expected = sep.next();
                    String a = new String (actual);
                    String e = new String (expected);
                    assertEquals(e.trim(),a.trim());
            }
  
}