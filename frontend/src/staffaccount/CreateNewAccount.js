import React, { useState, useEffect } from 'react';
import { Button, Card, CardBody, FormGroup, Form, Input, InputGroupAddon, InputGroupText, InputGroup, Col, Row, NavLink } from 'reactstrap';
import { addStaff, confirmStaff } from './staffApi';
import { useNavigate } from 'react-router-dom'; 
import CustomModal from './InfoModal'; 
import SuccessModal from './SuccessModal'; 

function CreateNewAccount() {
  const [formData, setFormData] = useState({
    email: '',
    username: '',
    password: '',
    permission_level:'0'
  });
  const navigate = useNavigate(); 

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [confirmationResponse, setConfirmationResponse] = useState(null);
  const [success, setSuccess] = useState(false); 
  const [addedUserEmail, setAddedUserEmail] = useState(null); 

  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    const emailParam = urlParams.get('email');

    if (successParam === 'true' && emailParam) {
      setSuccess(true);
      setAddedUserEmail(emailParam);
    }
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await addStaff(formData);
      console.log('Response:', response);
      setIsModalOpen(true);
      setFormData({
        email: '',
        username: '',
        password: ''
      });
    } catch (error) {
      console.error('Error:', error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  const handleConfirm = async () => {
    try {
      const confirmationData = {
        username: formData.username,
        email: formData.email,
        password: formData.password
      };
      const response = await confirmStaff(confirmationData);
      console.log('Confirmation response:', response);
      setConfirmationResponse(response);

      if (response && response.success) {
        console.log("User is successfully confirmed.");
        setSuccess(true);
      } else {
        console.error("Confirmation was not successful.");
      }
    } catch (error) {
      console.error('Error confirming staff:', error);
    }
  };

  const handleLogin = () => {
    navigate('/auth/login'); // Use navigate instead of history.push
  };

  return (
    <>
      <Col lg="5" md="8">
        <Card className="bg-secondary shadow border-0">
          <CardBody className="px-lg-5 py-lg-5">
            <div className="text-center text-muted mb-4">
              <small>Add a Super User Account</small>
            </div>
            <Form role="form" onSubmit={handleSubmit}>
              <FormGroup className="mb-3">
                <InputGroup className="input-group-alternative">
                  <InputGroupAddon addonType="prepend">
                    <InputGroupText>
                      <i className="ni ni-email-83" />
                    </InputGroupText>
                  </InputGroupAddon>
                  <Input
                    name="email"
                    placeholder="Email"
                    type="email"
                    autoComplete="new-email"
                    value={formData.email}
                    onChange={handleChange}
                  />
                </InputGroup>
              </FormGroup>
              <FormGroup className="mb-3">
                <InputGroup className="input-group-alternative">
                  <InputGroupAddon addonType="prepend">
                    <InputGroupText>
                      <i className="ni ni-circle-08" />
                    </InputGroupText>
                  </InputGroupAddon>
                  <Input
                    name="username"
                    placeholder="Username"
                    type="text"
                    autoComplete="new-username"
                    value={formData.username}
                    onChange={handleChange}
                  />
                </InputGroup>
              </FormGroup>
              <FormGroup>
                <InputGroup className="input-group-alternative">
                  <InputGroupAddon addonType="prepend">
                    <InputGroupText>
                      <i className="ni ni-lock-circle-open" />
                    </InputGroupText>
                  </InputGroupAddon>
                  <Input
                    name="password"
                    placeholder="Password"
                    type="password"
                    autoComplete="new-password"
                    value={formData.password}
                    onChange={handleChange}
                  />
                </InputGroup>
              </FormGroup>
              <div className="text-center">
                <Button className="my-3" color="primary" type="submit">
                  Sign up
                </Button>
              </div>
            </Form>
          </CardBody>
        </Card>
        <Row className="mt-3">
          <Col className="text-right" xs="12">
            <NavLink
              className="text-light"
              onClick={handleLogin}
            >
              <small>Back to Login</small>
            </NavLink>
          </Col>
        </Row>
      </Col>
      <CustomModal open={isModalOpen} closeModal={handleCloseModal} onConfirm={handleConfirm} />
      <SuccessModal open={success} closeModal={() => setSuccess(false)} userEmail={addedUserEmail} />
    </>
  );
}

export default CreateNewAccount;
