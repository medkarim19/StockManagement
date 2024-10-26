
import React, { useState, useEffect } from 'react';
import { Button, Modal, Form } from 'react-bootstrap';
import { updateUserById, getUserById } from 'users/userApi';
import Select from 'react-select';

const permissions_options = [
  { value: 'Admin', label: 'Admin' },
  { value: 'Editor', label: 'Editor' },
  { value: 'Viewer', label: 'Viewer' },
  { value: 'Edit', label: 'Edit' },
  { value: 'Delete', label: 'Delete' },
  { value: 'Create', label: 'Create' },
  { value: 'Modify', label: 'Modify' },
  { value: 'Refine', label: 'Refine' },
  { value: 'Emend', label: 'Emend' },
];


const UpdateModalComponent = ({ open, closeModal, userId, updateUsers }) => {
  
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    is_superuser: false,
  });
  const [selectedPermission, setSelectedPermission] = useState(null);

  useEffect(() => {
  }, [open, userId]);

  useEffect(() => {

    const fetchUserDetails = async () => {
      try {
        const user = await getUserById(userId);
        setFormData({
          username: user.username,
          email: user.email,
          is_superuser: user.is_superuser,
        });
      } catch (error) {
        console.error('Error fetching user details:', error);
      }
    };

    if (open && userId) {
      fetchUserDetails();
    }
  }, [open, userId]);

  const handleInputChange = (e) => {
    const { name, value, type } = e.target;
    setFormData((prevFormData) => ({
      ...prevFormData,
      [name]: type === "radio" ? value === "true" : value,
    }));
    console.log(formData);
  };

  const resetFormAndCloseModal = () => {
    setFormData({
      username: '',
      email: '',
      is_superuser: false,
    });
    closeModal();
  };

  const handleUpdate = async () => {
    try {
      const updateData = {
        ...formData,
        permission_level: selectedPermission?.value,
      };
      await updateUserById(userId, updateData);
      console.log('User updated successfully');
      resetFormAndCloseModal();
      if (typeof updateUsers === 'function') {
        updateUsers();
      }
    } catch (error) {
      console.error('Error updating user:', error);
    }
  };
  

  return (
    <Modal show={open} onHide={resetFormAndCloseModal} aria-labelledby="UpdateModalHeader" centered>
      <Modal.Header closeButton>
        <Modal.Title id='UpdateModalHeader'><h2>Edit User</h2></Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formUsername" style={{ marginBottom: '15px' }}>
            <Form.Label>Username:</Form.Label>
            <Form.Control
              type="text"
              placeholder="Username"
              name="username"
              value={formData.username}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          <Form.Group controlId="formEmail" style={{ marginBottom: '15px' }}>
            <Form.Label>Email:</Form.Label>
            <Form.Control
              type="email"
              placeholder="Email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>
          
          <Form.Group controlId="formPermission" style={{ marginBottom: '15px' }}>
            <Select
              options={permissions_options}
              placeholder="Permissions"
              value={selectedPermission}
              onChange={setSelectedPermission}
            />
          </Form.Group>
          

          <Form.Group controlId="formRole" style={{ marginBottom: '15px', display: 'flex', alignItems: 'center' }}>
            <Form.Label style={{ marginRight: '20px', marginBottom: '0' }}>Role :</Form.Label>
            <Form.Check
              inline
              type="radio"
              label="Regular User"
              name="is_superuser"
              checked={!formData.is_superuser}
              onChange={handleInputChange}
              style={{ marginRight: '20px' }}
              value="false"
            />
            <Form.Check
              inline
              type="radio"
              label="Super User"
              name="is_superuser"
              checked={formData.is_superuser}
              onChange={handleInputChange}
              value="true"
            />

          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant='secondary' onClick={resetFormAndCloseModal}>
          Cancel
        </Button>
        <Button variant='primary' onClick={handleUpdate}>
          Update
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default UpdateModalComponent;
