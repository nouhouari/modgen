package com.hin.modgen.sample.event.services;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.hin.modgen.sample.event.config.FileUploadProperties;
import com.hin.modgen.sample.event.exception.FileStorageException;
import com.hin.modgen.sample.event.model.UploadedFile;

@Service
public class FileService {

	private final Path fileStorageLocation;

	@Autowired
	public FileService(FileUploadProperties fileUploadProperties) {
		fileStorageLocation = Path.of(fileUploadProperties.getPath());
		File directory = new File(fileStorageLocation.toUri());
		if (!directory.exists()) {
			directory.mkdirs();
		}
	}

	void createPathIfNotExists(String path){
		Path toCheck = Path.of(path);
		File directory = new File(toCheck.toUri());
		if (!directory.exists()) {
			directory.mkdirs();
		}
	}

	/**
	 * Store file on local storage.
	 * 
	 * @param file File to be saved.
	 * @return random file name.
	 */
	public UploadedFile storeFile(MultipartFile file) {
		// Create random name
		String fileName = StringUtils.cleanPath(UUID.randomUUID().toString());
		try {
			Path targetLocation = this.fileStorageLocation.resolve(fileName);
			Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING); // Should never
																									// happen
			return UploadedFile.builder().fileName(fileName).build();
		} catch (IOException ex) {
			throw new FileStorageException("Could not store file " + fileName + ". Please try again!", ex);
		}
	}

	/**
	 * Get file from local storage
	 * 
	 * @param fileName
	 * @return
	 */
	public Resource loadFileAsResource(String fileName) {
		try {
			Path filePath = this.fileStorageLocation.resolve(fileName).normalize();
			Resource resource = new UrlResource(filePath.toUri());
			if (resource.exists()) {
				return resource;
			} else {
				throw new FileStorageException("File not found " + fileName);
			}
		} catch (MalformedURLException ex) {
			throw new FileStorageException("File not found " + fileName, ex);
		}
	}

}
