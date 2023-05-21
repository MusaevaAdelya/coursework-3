package edu.inai.coursework3.controllers;

import edu.inai.coursework3.util.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@RestController
@RequestMapping("/files")
class FileController {
    @Autowired
    private FileStorageService fileStorageService;


    @PostMapping("/courses")
    public ResponseEntity<String> uploadImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request) throws IOException {
        String fileName = fileStorageService.saveFile(file, "image");
        String fileUrl = request.getRequestURL().toString().replace(request.getRequestURI().substring(1), "") + "files/courses/image/" + fileName;
        String response = "<script>window.parent.CKEDITOR.tools.callFunction(" + request.getParameter("CKEditorFuncNum") + ", '" + fileUrl + "', '');</script>";
        return ResponseEntity.ok(response);
    }

}
