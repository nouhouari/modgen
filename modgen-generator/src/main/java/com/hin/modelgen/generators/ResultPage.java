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

package com.hin.modelgen.generators;

import java.util.ArrayList;
import java.util.List;

/**
 * This class is responsible of storing the pagination result.
 *
 * @author Nourreddine Houari <nourreddine.houari@>
 *
 */
public class ResultPage<T> {
  /**
   * Total amount of elements.
   */
  private int totalElements;
  /**
   * Number of current page.
   */
  private int number;
  /**
   * Number of element in the current page.
   */
  private long numberOfElements;
  /**
   * Page size.
   */
  private long size;
  /**
   * Total number of pages.
   */
  private long totalPages;
  /**
   * List of items in the current page.
   */
  private List<T> list = new ArrayList<>();
  /**
   * @return the totalElements
   */
  public int getTotalElements() {
    return totalElements;
  }
  /**
   * @param totalElements the totalElements to set
   */
  public void setTotalElements(int totalElements) {
    this.totalElements = totalElements;
  }
  /**
   * @return the number
   */
  public int getNumber() {
    return number;
  }
  /**
   * @param number the number to set
   */
  public void setNumber(int number) {
    this.number = number;
  }
  /**
   * @return the numberOfElements
   */
  public long getNumberOfElements() {
    return numberOfElements;
  }
  /**
   * @param numberOfElements the numberOfElements to set
   */
  public void setNumberOfElements(long numberOfElements) {
    this.numberOfElements = numberOfElements;
  }
  /**
   * @return the size
   */
  public long getSize() {
    return size;
  }
  /**
   * @param size the size to set
   */
  public void setSize(long size) {
    this.size = size;
  }
  /**
   * @return the totalPages
   */
  public long getTotalPages() {
    return totalPages;
  }
  /**
   * @param totalPages the totalPages to set
   */
  public void setTotalPages(long totalPages) {
    this.totalPages = totalPages;
  }
  /**
   * @return the list
   */
  public List<T> getList() {
    return list;
  }
  /**
   * @param list the list to set
   */
  public void setList(List<T> list) {
    this.list = list;
  }
  
}
