package code.service;

import code.bean.Employee;
import code.bean.EmployeeExample;
import code.mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpService {
    @Autowired
    EmployeeMapper employeeMapper;

    //查询全部员工信息
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    //插入员工信息
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //根据id查询单个员工
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
    //保存修改后的信息
    public void saveEmpUpdate(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    //删除单个
    public void delEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
    //批量删除
    public void delBatch(List<Integer> idList) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEIdIn(idList);
        employeeMapper.deleteByExample(employeeExample);
    }
}
