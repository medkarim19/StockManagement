import React, { useState, useEffect } from 'react';

const CustomModal = ({ open, closeModal }) => {
  const [isOpen, setIsOpen] = useState(open);

  useEffect(() => {
    setIsOpen(open);

    if (open) {
      const timeout = setTimeout(() => {
        setIsOpen(false);
        if (typeof closeModal === 'function') {
          closeModal(); 
        }
      }, 10000); 

      return () => clearTimeout(timeout);
    }
  }, [open, closeModal]); 

  const handleClose = () => {
    setIsOpen(false);
    if (typeof closeModal === 'function') {
      closeModal(); 
    }
  };

  const alertStyle = {
    position: 'fixed',
    top: '10px',
    left: '50%',
    transform: 'translateX(-50%)',
    backgroundColor: 'white',
    padding: '20px',
    borderRadius: '8px',
    minWidth: '60%',
    maxWidth: '60%',
    display: isOpen ? 'block' : 'none',
    zIndex: '1000',
    textAlign: 'center',
  };

  return (
    <div className="alert alert-secondary" role="alert" style={alertStyle}>
      <span className="alert-icon"><i className="ni ni-like-2"></i></span>
      <span className="alert-text"><strong>Alert for adding a Staff account!</strong> Check your email to confirm creating this staff by clicking on the link</span>
      <button type="button" className="close" onClick={handleClose} aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  );
};

export default CustomModal;
