package code.service;

import code.bean.Deparment;
import code.mapper.DeparmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {
    @Autowired
    private DeparmentMapper deparmentMapper;

    public List<Deparment> getAll(){
        return deparmentMapper.selectByExample(null);
    }
}
