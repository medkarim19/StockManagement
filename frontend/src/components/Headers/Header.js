import React, { useEffect, useState } from "react";
import { Card, CardBody, CardTitle, Container, Row, Col } from "reactstrap";
import { getUserCount, getUserCountWithinRange, getRegularUserCount, getStaffUserCount } from "users/userApi";
import { getProductCount, getProductCountWithinRange } from "products/productApi";
import { checkIsStaffStatus } from "users/userApi";
import { getProjectCount, getProjectCountWithinRange } from "projects/projectApi";
import { getOrderCount, getMonthlyOrderCount, getOrderCountWithinRange } from "orders/orderApi";

const Header = () => {
  const [userCount, setUserCount] = useState(null);
  const [userStaffCount, setUserStaffCount] = useState(null);
  const [userRegularCount, setUserRegularCount] = useState(null);
  const [productCount, setProductCount] = useState(null);
  const [projectCount, setProjectCount] = useState(null);
  const [orderCount, setOrderCount] = useState(null);
  const [productCountWithinRange, setProductCountWithinRange] = useState(null);
  const [projectCountWithinRange, setProjectCountWithinRange] = useState(null);
  const [orderCountWithinRange, setOrderCountWithinRange] = useState(null);
  const [userCountWithinRange, setUserCountWithinRange] = useState(null);
  const [userIsStaff, setUserIsStaff] = useState(false);

  const fetchData = async () => {
    // Fetch counts
    const totalUserCount = await getUserCount();
    setUserCount(totalUserCount);

    const regularUserCount = await getRegularUserCount();
    setUserRegularCount(regularUserCount);

    const staffUserCount = await getStaffUserCount();
    setUserStaffCount(staffUserCount);

    const totalProductCount = await getProductCount();
    setProductCount(totalProductCount);

    const totalProjectCount = await getProjectCount();
    setProjectCount(totalProjectCount);

    const totalOrderCount = await getOrderCount();
    setOrderCount(totalOrderCount);

    const currentDate = new Date();

    const startDate = new Date(currentDate);
    startDate.setMonth(currentDate.getMonth() - 1);
    const formattedStartDate = startDate.toISOString().split("T")[0];

    const endDate = new Date(currentDate);
    endDate.setDate(endDate.getDate() + 1);
    endDate.setHours(0);
    endDate.setMinutes(0);
    endDate.setSeconds(0);
    const formattedEndDate = endDate.toISOString().split("T")[0];

    const formattedStartDateEncoded = encodeURIComponent(formattedStartDate);
    const formattedEndDateEncoded = encodeURIComponent(formattedEndDate);

    const countWithinRange = await getUserCountWithinRange(
      formattedStartDateEncoded,
      formattedEndDateEncoded
    );
    setUserCountWithinRange(countWithinRange);

    const productCountRange = await getProductCountWithinRange(
      formattedStartDateEncoded,
      formattedEndDateEncoded
    );
    setProductCountWithinRange(productCountRange);

    const projectCountRange = await getProjectCountWithinRange(
      formattedStartDateEncoded,
      formattedEndDateEncoded
    );
    setProjectCountWithinRange(projectCountRange);

    const orderCountRange = await getOrderCountWithinRange(
      formattedStartDateEncoded,
      formattedEndDateEncoded
    );
    setOrderCountWithinRange(orderCountRange);
  };

  const updateCounts = async () => {
    try {
      await fetchData();
    } catch (error) {
      console.error("Error updating counts:", error);
    }
  };

  useEffect(() => {
    fetchData();

    // Polling to update counts every 10 seconds
    const interval = setInterval(fetchData, 3000);

    // Cleanup function to clear interval on component unmount
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    const checkIsStaff = async () => {
      const isStaff = await checkIsStaffStatus();
      setUserIsStaff(isStaff);
    };

    checkIsStaff();
  }, []);

  return (
    <>
    {userIsStaff ? (
      <div className="header bg-gradient-info pb-8 pt-5 pt-md-8">
        <Container fluid>
          <div className="header-body">
            {/* Card stats */}
            <Row>
              <Col lg="4">
                <Card className="card-stats mb-4 mb-xl-0">
                  <CardBody>
                    <Row>
                      <div className="col">
                        <CardTitle
                          tag="h5"
                          className="text-uppercase text-muted mb-0"
                        >
                          Total Users
                        </CardTitle>
                        <span className="h2 font-weight-bold mb-0">
                          {userCount !== null ? userCount : "Loading..."} 
                        </span>
                      </div>
                      <Col className="col-auto">
                        <div className="icon icon-shape bg-yellow text-white rounded-circle shadow">
                          <i className="fas fa-chart-pie" />
                        </div>
                      </Col>
                    </Row>
                    <span style={{opacity:0.8}}>Regular Users: {userRegularCount !== null ? userRegularCount : "Loading..."} | Staff Users: {userStaffCount !== null ? userStaffCount : "Loading..."}
                    </span>
                    <p className="mt-3 mb-0 text-muted text-sm">
                      {userCountWithinRange !== null ? (
                        <>
                          <span className="text-success mr-2">
                          <i className="fa fa-arrow-up" />{' '}
                            {((userCountWithinRange / userCount) * 100).toFixed(2)}%
                          </span>
                          <span className="text-nowrap">Since last week</span>
                        </>
                      ) : "Loading..."}
                    </p>
                    
                  </CardBody>
                </Card>
              </Col>
              <Col lg="4">
                <Card className="card-stats mb-4 mb-xl-0">
                  <CardBody>
                    <Row>
                      <div className="col">
                        <CardTitle
                          tag="h5"
                          className="text-uppercase text-muted mb-4"
                        >
                          Products
                        </CardTitle>
                        <span className="h2 font-weight-bold mb-0">
                          {productCount !== null ? productCount : "Loading..."}
                        </span>
                      </div>
                      <Col className="col-auto">
                        <div className="icon icon-shape bg-green text-white rounded-circle shadow">
                          <i className="fas fa-chart-bar" />
                        </div>
                      </Col>
                    </Row>
                    <p className="mt-3 mb-0 text-muted text-sm">
                      {productCountWithinRange !== null ? (
                        <>
                          <span className="text-success mr-2">
                            <i className="fa fa-arrow-up" />{' '}
                            {((productCountWithinRange / productCount) * 100).toFixed(2)}%
                          </span>
                          <span className="text-nowrap">Since last month</span>
                        </>
                      ) : "Loading..."}
                    </p>
                  </CardBody>
                </Card>
              </Col>
              <Col lg="4">
                <Card className="card-stats mb-4 mb-xl-0">
                  <CardBody>
                    <Row>
                      <div className="col">
                        <CardTitle
                          tag="h5"
                          className="text-uppercase text-muted mb-4"
                        >
                          Orders
                        </CardTitle>
                        <span className="h2 font-weight-bold mb-0">{orderCount !== null ? orderCount : "Loading..."}</span>
                      </div>
                      <Col className="col-auto">
                        <div className="icon icon-shape bg-red text-white rounded-circle shadow">
                          <i class="fa-solid fa-list-check"></i>
                        </div>
                      </Col>
                    </Row>
                    <p className="mt-3 mb-0 text-muted text-sm">
                  {orderCountWithinRange !== null ? (
                    <>
                      <span className="text-success mr-2">
                        <i className="fa fa-arrow-up" />{' '}
                        {((orderCountWithinRange / orderCount) * 100).toFixed(2)}%
                      </span>
                      <span className="text-nowrap">Since last month</span>
                    </>
                  ) : "Loading..."}
                </p>
                  </CardBody>
                </Card>
              </Col>
            </Row>
          </div>
        </Container>
      </div>
    ) : (<div className="header bg-gradient-info pb-8 pt-5 pt-md-8">
    <Container fluid>
      <div className="header-body">
        {/* Card stats */}
        <Row>
          <Col lg="6">
            <Card className="card-stats mb-4 mb-xl-0">
              <CardBody>
                <Row>
                  <div className="col">
                    <CardTitle
                      tag="h5"
                      className="text-uppercase text-muted mb-4"
                    >
                      Products
                    </CardTitle>
                    <span className="h2 font-weight-bold mb-0">
                      {productCount !== null ? productCount : "Loading..."}
                    </span>
                  </div>
                  <Col className="col-auto">
                    <div className="icon icon-shape bg-danger text-white rounded-circle shadow">
                      <i className="fas fa-chart-bar" />
                    </div>
                  </Col>
                </Row>
                <p className="mt-3 mb-0 text-muted text-sm">
                  {productCountWithinRange !== null ? (
                    <>
                      <span className="text-success mr-2">
                        <i className="fa fa-arrow-up" />{' '}
                        {((productCountWithinRange / productCount) * 100).toFixed(2)}%
                      </span>
                      <span className="text-nowrap">Since last month</span>
                    </>
                  ) : "Loading..."}
                </p>
              </CardBody>
            </Card>
          </Col>
          <Col lg="6">
            <Card className="card-stats mb-4 mb-xl-0">
              <CardBody>
                <Row>
                  <div className="col">
                    <CardTitle
                      tag="h5"
                      className="text-uppercase text-muted mb-4"
                    >
                      Projects
                    </CardTitle>
                    <span className="h2 font-weight-bold mb-0">
                      {projectCount !== null ? projectCount : "Loading..."}
                    </span>
                  </div>
                  <Col className="col-auto">
                    <div className="icon icon-shape bg-danger text-white rounded-circle shadow">
                    <i class="fa-solid fa-list-check"></i>
                    </div>
                  </Col>
                </Row>
                <p className="mt-3 mb-0 text-muted text-sm">
                  {productCountWithinRange !== null ? (
                    <>
                      <span className="text-success mr-2">
                        <i className="fa fa-arrow-up" />{' '}
                        {((projectCountWithinRange / projectCount) * 100).toFixed(2)}%
                      </span>
                      <span className="text-nowrap">Since last month</span>
                    </>
                  ) : "Loading..."}
                </p>
              </CardBody>
            </Card>
          </Col>
          </Row>
            </div>
          </Container>
        </div>)}
    </>
  );
};

export default Header;
