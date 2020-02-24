package code.controller;

import code.bean.Deparment;
import code.service.DeptService;
import code.utils.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {
    @Autowired
    private DeptService deptService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Deparment> depts = deptService.getAll();
        return Msg.success().add("depts",depts);
    }
}
