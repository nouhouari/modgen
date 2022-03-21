package com.hin.modgen.sample.event.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UploadedFile {
    private String fileName;
}
