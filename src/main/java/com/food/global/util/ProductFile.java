package com.food.global.util;

import java.io.File;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.food.domain.product.dto.ProductFileDTO;
import com.food.domain.sales.dto.SalesPostFileDTO;

@Component
public class ProductFile {

    @Value("${file.upload-dir}")
    private String uploadDir;

    public ProductFileDTO parseFileInfo(String productNumber, MultipartFile productFile) throws Exception {

        if (ObjectUtils.isEmpty(productFile)) {
            return null;
        }

        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd");
        ZonedDateTime current = ZonedDateTime.now();

        // 파일 저장 경로 설정에 커스텀 프로퍼티 값 사용
        String absolutePath = uploadDir + "images/" + current.format(format);
        String path = "/images/" + current.format(format);
        File file = new File(absolutePath);
        if (!file.exists()) {
            file.mkdirs();
        }

        String newFileName;
        String originalFileExtension = "";
        String contentType;

        if (!productFile.isEmpty()) {
            contentType = productFile.getContentType();
            if (ObjectUtils.isEmpty(contentType)) {
                return null;
            } else {
                switch (contentType) {
                    case "image/jpeg":
                        originalFileExtension = "jpg";
                        break;
                    case "image/png":
                        originalFileExtension = "png";
                        break;
                    case "image/svg+xml":
                        originalFileExtension = "svg";
                        break;
                    case "image/gif":
                        originalFileExtension = "gif";
                        break;
                    default:
                        return null;
                }
            }

            newFileName = Long.toString(System.nanoTime()) + "." + originalFileExtension;

            ProductFileDTO productFileDTO = new ProductFileDTO();
            productFileDTO.setProductNumber(productNumber);
            productFileDTO.setOriginalName(productFile.getOriginalFilename());
            productFileDTO.setFilePath(path + "/" + newFileName); // 저장 경로 수정
            productFileDTO.setUploadDate(LocalDateTime.now());
            productFileDTO.setFileType(originalFileExtension); // 파일 타입 저장
            file = new File(absolutePath + "/" + newFileName);
            productFile.transferTo(file);

            return productFileDTO;
        }

        return null;
    }
    
}
