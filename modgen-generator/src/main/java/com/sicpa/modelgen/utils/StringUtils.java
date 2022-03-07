/*
 * 
 * Nourreddine HOUARI CONFIDENTIAL
 * 
 * All information contained herein is, and remains
 * the property of Nourreddine HOUARI and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Nourreddine HOUARI
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 * 
 * [2017] Nourreddine HOUARI SA
 * All Rights Reserved.
 */

package com.sicpa.modelgen.utils;

public class StringUtils {

  
  /**
   * Set the first character to capital letter.
   * @param s
   * @return
   */
  public static String capFirst(String s){
    int firstChar = s.charAt(0);
    String result = s;
    if(firstChar>=97 && firstChar <=122){
      firstChar -= 32;
      char[] charArray = s.toCharArray();
      charArray[0] = (char) firstChar;
      result = new String(charArray);
    }
    return result;
  }
  
}
