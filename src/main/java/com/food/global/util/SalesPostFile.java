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

import com.food.domain.sales.dto.SalesPostFileDTO;

@Component
public class SalesPostFile {

    @Value("${file.upload-dir}")
    private String uploadDir;

    public List<SalesPostFileDTO> parseFileInfos(Long salesPostId, MultipartFile[] salesPostFiles) throws Exception {
        List<SalesPostFileDTO> fileDTOList = new ArrayList<>();

        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd");
        ZonedDateTime current = ZonedDateTime.now();

        String absolutePath = uploadDir + "images/" + current.format(format);
        String path = "/images/" + current.format(format);
        File directory = new File(absolutePath);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        for (MultipartFile salesPostFile : salesPostFiles) {
            if (ObjectUtils.isEmpty(salesPostFile)) {
                continue;
            }

            String newFileName;
            String originalFileExtension = "";
            String contentType;

            if (!salesPostFile.isEmpty()) {
                contentType = salesPostFile.getContentType();
                if (ObjectUtils.isEmpty(contentType)) {
                    continue;
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
                            continue;
                    }
                }

                newFileName = Long.toString(System.nanoTime()) + "." + originalFileExtension;

                SalesPostFileDTO salesPostFileDTO = new SalesPostFileDTO();
                salesPostFileDTO.setSalesPostId(salesPostId);
                salesPostFileDTO.setOriginalName(salesPostFile.getOriginalFilename());
                salesPostFileDTO.setFilePath(path + "/" + newFileName);
                salesPostFileDTO.setUploadDate(LocalDateTime.now());
                salesPostFileDTO.setFileType(originalFileExtension);
                File file = new File(absolutePath + "/" + newFileName);
                
                // 로그 추가
                System.out.println("Saving file to: " + file.getAbsolutePath());
                
                salesPostFile.transferTo(file);
                
                fileDTOList.add(salesPostFileDTO);
            }
        }
        System.out.println("fileDTOList = " + fileDTOList);
        return fileDTOList;
    }
}