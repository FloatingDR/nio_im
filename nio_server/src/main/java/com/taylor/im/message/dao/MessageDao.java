package com.taylor.im.message.dao;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.taylor.im.message.entity.po.MessagePo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 消息表 Mapper 接口
 * </p>
 *
 * @author taylor
 * @since 2020-02-23
 */
public interface MessageDao extends BaseMapper<MessagePo> {

    String COLUMNS = "id, user_id, data, signed";

    /**
     * <p>
     * 保存message
     * </p>
     *
     * @param messagePo messagePo
     * @author taylor
     * @date 2020/2/23 13:16
     */
    @Insert("INSERT INTO message(user_id,data) VALUES (#{userId},#{data})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void saveMessage(MessagePo messagePo);

    /**
     * <p>
     * 获取用户未读消息
     * </p>
     *
     * @param wrapper 条件
     * @return {@link List<MessagePo> }
     * @author taylor
     * @date 2020/2/23 15:41
     */
    @Select("SELECT " + COLUMNS + " FROM message ${ew.customSqlSegment}")
    List<MessagePo> searchUserUnread(@Param(Constants.WRAPPER) Wrapper<MessagePo> wrapper);
}
