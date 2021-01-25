export default function(socket, id, sequence) {
    let count = 0;
    const element = document.getElementById(id);
    element.ontouchstart = () => {
        if (++count === 1) {
            element.classList.add("down");
            socket.sendSeq(sequence);
        }
        return false;
    };
    element.ontouchend = element.ontouchcancel = () => {
        if (--count === 0) {
            element.classList.remove("down");
        }
        return false;
    };
}