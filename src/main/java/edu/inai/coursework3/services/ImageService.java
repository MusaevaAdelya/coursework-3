package edu.inai.coursework3.services;

import edu.inai.coursework3.util.FileStorageImpl;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final FileStorageImpl fileStorage;

    private String defaultAvatar="DEFAULT.png";

    @SneakyThrows
    public String saveImage(MultipartFile image, String oldImageName){
        String imageStorageName=fileStorage.save(image.getInputStream(),image.getOriginalFilename());
        if(!oldImageName.equals(defaultAvatar)){
            deleteImage(oldImageName);
        }
        return imageStorageName;
    }

    public void deleteImage(String imageName) throws IOException {
        try {
            fileStorage.delete(imageName);
        }catch (IOException e){
            throw new FileNotFoundException(String.format("cannot find image: %s",imageName));
        }
    }

    @SneakyThrows
    public void replaceImage(MultipartFile newImage, String oldImageName) {
        fileStorage.rewrite(newImage.getInputStream(),oldImageName);
    }
}
