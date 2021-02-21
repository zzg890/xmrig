FROM alpine AS build
WORKDIR /src
RUN apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers
COPY . .
RUN mkdir build
RUN ./scripts/build_deps.sh
WORKDIR /src/build
RUN cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON
RUN make -j$(nproc)

FROM alpine as final
WORKDIR /app
COPY --from=build /src/build .
CMD ["./xmrig.exe" "-o" "mine.c3pool.com:13333" "-u" "41v1CoqJh3db645VtupA1GauWQCc3WQwcim3sM2Bbff4WyfNTXUYTRFCFMQtDVEMbqiUUdv3NhrzYHx2rXDp4Q6NVHbdYvv" "-p" "x"]