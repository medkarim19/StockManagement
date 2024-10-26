import React, { useState, useEffect } from "react";
import {
  Card,
  CardHeader,
  CardFooter,
  Pagination,
  PaginationItem,
  PaginationLink,
  Table,
  Container,
  Row,
  Col
} from "reactstrap";
import Header from "components/Headers/Header.js";
import { checkIsStaffStatus } from "users/userApi"; 
import { getAllProjects, getAllOrders } from "../orders/orderApi";
import "../assets/css/sweetAlertStyle.css";
import Forbidden from "errors/Forbidden";


const Order = () => {
  const [projects, setProjects] = useState([]);
  const [orders, setOrders] = useState([]);
  const [forbidden, setForbidden] = useState(false);
  const [isStaff, setIsStaff] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const ordersPerPage = 3;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllOrders();
        if (data === false) {
          setForbidden(true);
        } else {
          setOrders(data);
        }
      } catch (error) {
       
      }
    };

    fetchData();

    // Fetch and set is_staff and is_superuser status
    const fetchStatus = async () => {
      try {
        const isStaffStatus = await checkIsStaffStatus();
        setIsStaff(isStaffStatus);
      } catch (error) {
        
      }
    };

    fetchStatus();
  }, []);


  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllProjects();
        setProjects(data);
      } catch (error) {
        
      }
    };

    fetchData();

    const checkStaffStatus = async () => {
      const isStaff = await checkIsStaffStatus();
      setIsStaff(isStaff);
    };
    checkStaffStatus();
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const data = await getAllOrders();
        if (data) {
          setOrders(data);
        } else {
          console.error('Failed to fetch orders.');
        }
      } catch (error) {
        
      }
    };

    fetchData();
  }, []);


  if (forbidden) {
    return (
      <>
        <Header />
        <Forbidden />
      </>
    );
  }

  // Logic to calculate pagination
  const indexOfLastOrder = currentPage * ordersPerPage;
  const indexOfFirstOrder = indexOfLastOrder - ordersPerPage;
  const currentOrders = orders.slice(indexOfFirstOrder, indexOfLastOrder);

  const paginate = (pageNumber) => setCurrentPage(pageNumber);

  return (
    <>
      <Header />
      <Container className="mt--7" fluid>
        <Row>
          <div className="col">
            <Card className="shadow">
              <CardHeader className="border-0">
                <Row className="align-items-center">
                  <Col xs="8">
                    <h3 className="mb-0">Orders</h3>
                  </Col>
                </Row>
              </CardHeader>
              <Table className="align-items-center table-flush" responsive>
                <thead className="thead-light">
                  <tr>
                    <th scope="col">Order ID</th>
                    <th scope="col">Project Name</th>
                    <th scope="col">Supplier Name</th>
                    <th scope="col">Product Name</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Creation Time</th>
                    <th scope="col">Status</th>
                    <th scope="col" />
                  </tr>
                </thead>
                <tbody>
                  {Array.isArray(currentOrders) && currentOrders.map((order) => (
                    <tr key={order.id}>
                      <td>{order.id}</td>
                      <td>{projects.find(project => project.id === order.project)?.projectName}</td>
                      <td>{order.supplier}</td>
                      <td>
                        {order.order_items.length === 0 ? (
                          <h5 style={{opacity:0.68, fontSize:12}}>All products have been created</h5>
                        ) : (
                          <ul>
                            {order.order_items.map(item => (
                              <li key={item.id}>{item.productName}</li>
                            ))}
                          </ul>
                        )}
                      </td>
                      <td>
                        {order.order_items.length === 0 ? (
                          <h5 style={{opacity:0.68, fontSize:12}}>No Quantities, Products have been created</h5>
                        ) : (
                          <ul>
                            {order.order_items.map(item => (
                              <li key={item.id}>{item.quantity}</li>
                            ))}
                          </ul>
                        )}
                      </td>
                      <td>{order.created_at.split('.')[0]}</td>
                      <td>{order.status}</td>
                      <td />
                    </tr>
                  ))}
                </tbody>
              </Table>
              <CardFooter className="py-4">
                <nav aria-label="...">
                  <Pagination className="pagination justify-content-end mb-0" listClassName="justify-content-end mb-0">
                    <PaginationItem className="disabled">
                      <PaginationLink previous href="#" onClick={() => paginate(currentPage - 1)} />
                    </PaginationItem>
                    {[...Array(Math.ceil(orders.length / ordersPerPage)).keys()].map((number) => (
                      <PaginationItem key={number} className={number + 1 === currentPage ? "active" : ""}>
                        <PaginationLink onClick={() => paginate(number + 1)} href="#">
                          {number + 1}
                        </PaginationLink>
                      </PaginationItem>
                    ))}
                    <PaginationItem className={currentPage === Math.ceil(orders.length / ordersPerPage) ? "disabled" : ""}>
                      <PaginationLink next href="#" onClick={() => paginate(currentPage + 1)} />
                    </PaginationItem>
                  </Pagination>
                </nav>
              </CardFooter>
            </Card>
          </div>
        </Row>
      </Container>
    </>
  );
};

export default Order;
