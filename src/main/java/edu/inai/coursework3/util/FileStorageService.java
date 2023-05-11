package edu.inai.coursework3.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FileStorageService {

    void init();

    String saveFile(MultipartFile file, String directoryName) throws IOException;


}
