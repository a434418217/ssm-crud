package code.test;

import code.bean.Employee;
import code.mapper.DeparmentMapper;
import code.mapper.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//使用spring的单元测试
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-mybatis.xml"})
public class MapperTest {

        @Autowired
        DeparmentMapper deparmentMapper;

        @Autowired
        EmployeeMapper employeeMapper;

//        批量sqlsession
        @Autowired
        SqlSession sqlSession;

        @Test
        public void Test01(){
            System.out.println(deparmentMapper);
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            String s = UUID.randomUUID().toString().substring(0,6);
            for (int i = 0; i <10 ; i++) {
                mapper.insertSelective(new Employee(null,s+i,"m",s+"@qq.com",3));
            }


        }
}
