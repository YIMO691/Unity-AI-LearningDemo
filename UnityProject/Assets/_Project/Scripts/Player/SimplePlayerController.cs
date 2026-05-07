using UnityEngine;
using UnityEngine.InputSystem;

public class SimplePlayerController : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float mouseSensitivity = 2f;

    private float _pitch;
    private Vector2 _moveInput;

    private void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    private void Update()
    {
        if (Mouse.current == null || Keyboard.current == null) return;

        // Mouse look
        Vector2 mouseDelta = Mouse.current.delta.ReadValue();
        float yaw = mouseDelta.x * mouseSensitivity * Time.deltaTime;
        _pitch -= mouseDelta.y * mouseSensitivity * Time.deltaTime;
        _pitch = Mathf.Clamp(_pitch, -80f, 80f);
        transform.Rotate(Vector3.up, yaw);
        Camera.main.transform.localRotation = Quaternion.Euler(_pitch, 0f, 0f);

        // WASD movement
        Vector2 input = Vector2.zero;
        if (Keyboard.current.wKey.isPressed) input.y += 1;
        if (Keyboard.current.sKey.isPressed) input.y -= 1;
        if (Keyboard.current.dKey.isPressed) input.x += 1;
        if (Keyboard.current.aKey.isPressed) input.x -= 1;

        Vector3 move = (transform.right * input.x + transform.forward * input.y).normalized * moveSpeed * Time.deltaTime;
        transform.Translate(move, Space.World);
    }
}
