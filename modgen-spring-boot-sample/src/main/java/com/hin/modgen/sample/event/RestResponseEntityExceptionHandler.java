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
 * [2019] Nourreddine HOUARI SA
 * All Rights Reserved.
 */

package com.hin.modgen.sample.event;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;

import com.hin.modgen.sample.event.dto.ErrorInfo;

/**
 * Handle exceptions.
 */
@Slf4j
@RequiredArgsConstructor
@ControllerAdvice
public class RestResponseEntityExceptionHandler {
  /* 500 series */
  @ExceptionHandler({AsyncRequestTimeoutException.class})
  public ResponseEntity<ErrorInfo> handleRequestTimeout(final RuntimeException ex) {
    return prepareResponse(HttpStatus.SERVICE_UNAVAILABLE, ex);
  }

  /* Default */
  @ExceptionHandler({Exception.class})
  public ResponseEntity<ErrorInfo> handleInternalException(final Exception ex) {
    return prepareResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex);
  }

  private ResponseEntity<ErrorInfo> prepareResponse(HttpStatus status, Exception ex) {
    log.error(ex.getMessage(), ex);
    int code = status.value();

    return new ResponseEntity<>(ErrorInfo
        .builder()
        .error(ex.getMessage())
        .code(code)
        .build(),
        status);
  }
}
