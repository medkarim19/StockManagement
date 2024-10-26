import React, { useState } from 'react';
import { Button, Modal, Form } from 'react-bootstrap';
import { addUser } from 'users/userApi';

const AddModalComponent = ({ open, closeModal, updateUsers }) => {
  const initialFormData = {
    username: '',
    email: '',
    password: '',
  };

  const [formData, setFormData] = useState(initialFormData);
  const [selectedPermission, setSelectedPermission] = useState(null);
  const [isStaff, setIsStaff] = useState(false); // Track if the user is staff

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    if (type === "radio" && name === "role") {
      setIsStaff(value === "staffuser"); // Update isStaff state based on radio button value
      setFormData({
        ...formData,
        is_staff: value === "staffuser", 
      });
    } else if (type === "checkbox") {
      setFormData({ ...formData, [name]: checked }); // Set create to checked state
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const getPermissionLevel = () => {
    if (formData.create && formData.update && formData.delete) {
      return 'Editor';
    } else if (formData.create && formData.update) {
      return 'Refine';
    } else if (formData.create && formData.delete) {
      return 'Edit';
    } else if (formData.update && formData.delete) {
      return 'Emend';
    } else if (formData.create) {
      return 'Create';
    } else if (formData.update) {
      return 'Modify';
    } else if (formData.delete) {
      return 'Delete';
    } else {
      return 'Viewer';
    }
  };

  const resetFormAndCloseModal = () => {
    setFormData(initialFormData);
    closeModal();
  };

  const handleSave = async () => {
    try {
      const userData = { ...formData };
  
      // Remove create, update, and delete properties
      delete userData.create;
      delete userData.update;
      delete userData.delete;
  
      if (isStaff) {
        // Add permissions to userData if the user is a staff user
        userData.permissions = {
          create: formData.create || false,
          update: formData.update || false,
          delete: formData.delete || false
        };
        // Set permission_level based on selected permissions
        userData.permission_level = getPermissionLevel();
        // Remove the permissions object
        delete userData.permissions;
      } else {
        // Set permission_level for regular user
        userData.permission_level = 'Viewer';
      }
  
      await addUser(userData);
      console.log('New user added successfully');
      resetFormAndCloseModal();
      if (typeof updateUsers === 'function') {
        updateUsers();
      }
    } catch (error) {
      
    }
  };
  
  return (
    <Modal show={open} onHide={resetFormAndCloseModal} aria-labelledby="ModalHeader" centered>
      <Modal.Header closeButton>
        <Modal.Title id='ModalHeader'><h2>Add User</h2></Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formUsername" style={{ marginBottom: '15px' }}>
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
            <Form.Control
              type="email"
              placeholder="Email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>
          <Form.Group controlId="formPassword" style={{ marginBottom: '15px' }}>
            <Form.Control
              type="password"
              placeholder="Password"
              name="password"
              value={formData.password}
              onChange={handleInputChange}
              style={{ width: '100%' }}
            />
          </Form.Group>

          <Form.Group controlId="formRole" style={{ marginBottom: '15px', display: 'flex', alignItems: 'center' }}>
            <Form.Label style={{ marginRight: '20px', marginBottom: '0' }}>Role :</Form.Label>
            <Form.Check
              inline
              type="radio"
              label="Regular User"
              name="role" // Use the same name for both radio buttons
              value="regularuser"
              onChange={handleInputChange}
              style={{ marginRight: '20px' }}
            />
            <Form.Check
              inline
              type="radio"
              label="Staff User"
              name="role" // Use the same name for both radio buttons
              value="staffuser"
              onChange={handleInputChange}
            />
          </Form.Group>

          {isStaff && ( // Render checkboxes only if user is staff
            <Form.Group controlId="formPermissions" style={{ marginBottom: '15px' }}>
              <Form.Check
                type="checkbox"
                label="Create"
                name="create"
                onChange={handleInputChange}
              />
              <Form.Check
                type="checkbox"
                label="Update"
                name="update"
                onChange={handleInputChange}
              />
              <Form.Check
                type="checkbox"
                label="Delete"
                name="delete"
                onChange={handleInputChange}
              />
            </Form.Group>
          )}

        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant='secondary' onClick={resetFormAndCloseModal}>
          Cancel
        </Button>
        <Button variant='primary' onClick={handleSave}>
          Save
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default AddModalComponent;
