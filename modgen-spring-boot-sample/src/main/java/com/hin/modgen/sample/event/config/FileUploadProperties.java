package com.hin.modgen.sample.event.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Configuration
@ConfigurationProperties(prefix = "upload")
@Data
public class FileUploadProperties {
	private String path = "fileUpload"; // Default value: fileUpload
}
