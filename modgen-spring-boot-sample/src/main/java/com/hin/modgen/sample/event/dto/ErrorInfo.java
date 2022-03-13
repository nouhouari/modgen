package com.hin.modgen.sample.event.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

/**
 *
 */
@Getter
@Setter
@Builder
public class ErrorInfo {
  int code;
  String error;
}