package com.taylor.im.file.service.impl;

import com.taylor.im.exception.BaseException;
import com.taylor.im.file.entity.HeaderImg;
import com.taylor.im.file.service.IFileService;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.PosixFileAttributes;
import java.nio.file.attribute.PosixFilePermission;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.Set;
import java.util.UUID;

/**
 * <p>
 * file服务层接口实现类
 * </p>
 *
 * @author taylor
 * @date 2020/3/1 13:40
 */
@Service
public class FileServiceImpl implements IFileService {

    @Value("${nginx.root_path}")
    private String path;

    @Value("${nginx.host}")
    private String host;

    @Value("${nginx.port}")
    private Integer port;

    @Value("${nginx.height}")
    private Integer height;

    @Override
    public String upload(Long userId, MultipartFile file) throws Exception {
        String uuidOriginalName = getFileName(userId, file);
        Path p = Paths.get(path + uuidOriginalName);
        Path newFile = null;
        if (!Files.exists(p)) {
            newFile = Files.createFile(p);
        }
        InputStream in = file.getInputStream();
        assert newFile != null;
        Files.copy(in, newFile, StandardCopyOption.REPLACE_EXISTING);
        return String.format("http://%s:%s/%s", host, port, uuidOriginalName);
    }


    @Override
    public String reduceImg(Long userId, MultipartFile img) throws Exception {
        String fileName = getFileName(userId, img);
        FileInputStream fileInputStream = (FileInputStream) img.getInputStream();
        BufferedImage bufferedImage = ImageIO.read(fileInputStream);
        // 压缩比例
        int scale = (bufferedImage.getHeight()) / height;
        int width = bufferedImage.getWidth() / scale;
        Thumbnails.of(bufferedImage).size(height, width).toFile(path + fileName);
        return String.format("http://%s:%s/%s", host, port, fileName);
    }

    @Override
    public HeaderImg uploadHeaderImg(Long userId, MultipartFile file) throws Exception {
        return HeaderImg.builder()
                .img(upload(userId, file))
                .imgReduce(reduceImg(userId, file))
                .build();
    }


    //------------------------------------------------------------------
    //        util methods
    //------------------------------------------------------------------


    /**
     * <p>
     * 获取文件名
     * </p>
     *
     * @param userId userId
     * @param file   file
     * @return {@link String }
     * @author taylor
     * @date 2020/3/1 15:44
     */
    private String getFileName(Long userId, MultipartFile file) throws Exception {
        // 检查文件
        checkImgValid(file);
        // 检查权限
        Path dir = Paths.get(path);
//        checkPermissions(dir);

        if (!Files.exists(dir)) {
            Files.createDirectory(dir);
        }
        String fileType = getFileType(file);
        return userId + "_" + uuid() + "." + fileType;
    }


    /**
     * 截取文件类型
     *
     * @param file 文件
     * @return 文件类型
     */
    private String getFileType(MultipartFile file) {
        String originalFilename = file.getOriginalFilename();
        assert originalFilename != null;
        int i = originalFilename.lastIndexOf(".");
        return originalFilename.substring(i + 1);
    }

    /**
     * <p>
     * 生成uuid
     * </p>
     *
     * @return {@link String }
     * @author taylor
     * @date 2020/3/1 13:30
     */
    private String uuid() {
        String uuid = UUID.randomUUID().toString();
        return uuid.replaceAll("-", "");
    }

    /**
     * <p>
     * 检查文件是否合法
     * </p>
     *
     * @param originFile MultipartFile
     * @author taylor
     * @date 2020/3/1 13:40
     */
    private void checkImgValid(MultipartFile originFile) throws Exception {
        //校验文件格式
        if (originFile == null) {
            throw new BaseException("未检测到文件");
        }
        if (originFile.getOriginalFilename() == null) {
            throw new BaseException("文件名不能为空");
        }
        String suffixs = ".bmp.jpg.png.BMP.JPG.PNG.jpeg.JPEG";
        String suffix = originFile.getOriginalFilename().substring(originFile.getOriginalFilename()
                .lastIndexOf("."));
        if (!suffixs.contains(suffix)) {
            throw new BaseException("图片格式有误，必须为bmp, jpg, png，jpeg图片格式中的一种");
        }
    }

    /**
     * <p>
     * 检查权限
     * </p>
     *
     * @param path path
     * @author taylor
     * @date 2020/3/1 14:42
     */
    private void checkPermissions(Path path) throws IOException {
        //获得属性视图
        PosixFileAttributes attrs = Files.readAttributes(path, PosixFileAttributes.class);
        //得到权限集合
        Set<PosixFilePermission> posixFilePermission = attrs.permissions();
        //清除所有权限
        posixFilePermission.clear();
        //得到文件所有者
        String owner = attrs.owner().getName();
        //得到权限的字符串形式
        String perms = PosixFilePermissions.toString(posixFilePermission);
        //加入自定义权限
        posixFilePermission.add(PosixFilePermission.OWNER_READ);
        posixFilePermission.add(PosixFilePermission.OWNER_WRITE);
        posixFilePermission.add(PosixFilePermission.OTHERS_READ);
        posixFilePermission.add(PosixFilePermission.OTHERS_WRITE);

        //写入权限
        Files.setPosixFilePermissions(path, posixFilePermission);

    }
}
