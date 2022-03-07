package com.sicpa.modgen.horizon.inspection.dto;

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