package kr.or.ddit.noticeBoard.service;


import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.FileNotFoundException;

@Service
@RequiredArgsConstructor
public class FileStorageServiceImpl implements FileStorageService{

    @Value("#{appInfo['noticeBoard.attatchPath']}")
    private String uploadDir;

    public Resource loadFileAsResource(String fileName) {
        try {
            Resource resource = new FileSystemResource(uploadDir + fileName);
            if(resource.exists()) {
                return resource;
            } else {
                throw new FileNotFoundException("File not found " + fileName);
            }
        } catch (Exception e) {
            throw new RuntimeException("File not found " + fileName, e);
        }
    }
}

