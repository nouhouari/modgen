package com.hin.modgen.sample.event.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hin.modgen.sample.event.model.UploadedFile;
import com.hin.modgen.sample.event.services.FileService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("file")
@Slf4j
public class FileController {

	@Autowired
	private FileService fileService;

	@PostMapping(produces = "application/json")
	public @ResponseBody UploadedFile uploadFile(
			@RequestParam("file") MultipartFile file) {
		return this.fileService.storeFile(file);
	}

	@GetMapping
	public ResponseEntity<Resource> getFile(@NotBlank @RequestParam String fileName, HttpServletRequest request) {
		// Load file as Resource
		Resource resource = this.fileService.loadFileAsResource(fileName);

		// Try to determine file's content type
		String contentType = null;
		try {
			contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
		} catch (IOException ex) {
			log.info("Could not determine file type.");
		}

		// Fallback to the default content type if type could not be determined
		if (contentType == null) {
			contentType = "application/octet-stream";
		}

		return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
				.body(resource);
	}
}