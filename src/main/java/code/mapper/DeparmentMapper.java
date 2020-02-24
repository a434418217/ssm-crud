package code.mapper;

import code.bean.Deparment;
import code.bean.DeparmentExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface DeparmentMapper {
    long countByExample(DeparmentExample example);

    int deleteByExample(DeparmentExample example);

    int deleteByPrimaryKey(Integer dId);

    int insert(Deparment record);

    int insertSelective(Deparment record);

    List<Deparment> selectByExample(DeparmentExample example);

    Deparment selectByPrimaryKey(Integer dId);

    int updateByExampleSelective(@Param("record") Deparment record, @Param("example") DeparmentExample example);

    int updateByExample(@Param("record") Deparment record, @Param("example") DeparmentExample example);

    int updateByPrimaryKeySelective(Deparment record);

    int updateByPrimaryKey(Deparment record);
}