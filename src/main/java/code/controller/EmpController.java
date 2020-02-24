package code.controller;

import code.bean.Employee;
import code.service.EmpService;
import code.utils.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class EmpController {

    @Autowired
    EmpService empService;

    //使用json进行数据传输  查询全部
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    @ResponseBody
    public Msg getAll(@RequestParam(value = "page" ,defaultValue = "1")Integer page){
        PageHelper.startPage(page,5);   //页码    一页多少条数据
        List<Employee> emps = empService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);   //数据    显示的页码数量
        return Msg.success().add("pageInfo",pageInfo);
    }



    //保存员工
    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        empService.saveEmp(employee);
        return Msg.success();
    }

    //查询员工信息
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = empService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

//    修改员工
    @RequestMapping(value = "/emp/{eId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmpUpdate(Employee employee){
        empService.saveEmpUpdate(employee);
        return Msg.success();
    }

    /**
     * 单个删除和批量删除
     * @param ids   传过来的id字符串
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            List<Integer> idList = new ArrayList<Integer>();
            String[] newId = ids.split("-");
            for (String id: newId) {
                idList.add(Integer.parseInt(id));
            }
            empService.delBatch(idList);
            return Msg.success();
        }else{
            //将字符串转为Integer
            empService.delEmp(Integer.parseInt(ids));
            return Msg.success();
        }

    }

}
